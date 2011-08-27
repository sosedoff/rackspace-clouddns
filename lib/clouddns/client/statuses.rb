module CloudDns
  module Statuses
    # Get asynchronous response contents
    #
    def status(job_id)
      get("/status/#{job_id}")
    end
  end
end
