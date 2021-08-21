require 'new_relic/agent/tracer'

module Mysql2Instrumentation
  def query(query, *)
    segment = NewRelic::Agent::Tracer.start_datastore_segment(
      product: 'MySQL',
      operation: query[/\A\s*(?:SELECT|INSERT|UPDATE|DELETE|BEGIN|COMMIT|ROLLBACK)/i]&.upcase,
      collection: query.scan(/(?:FROM|UPDATE|INTO)\s*`?(\w+)/i).first&.first,
    )
    begin
      segment.notice_sql(query)
      super
    rescue Mysql2::Error
      STDERR.puts "Mysql2: #{query}"
      raise
    ensure
      segment.finish
    end
  end
end

if defined?(::Mysql2::Client)
  ::Mysql2::Client.prepend(Mysql2Instrumentation)
end
