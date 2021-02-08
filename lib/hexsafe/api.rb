module Hexsafe
	class Api
  	class Error < RuntimeError; end

  	def initialize options = {}
  		@mode   = options[:env].upcase rescue nil
  		@key    = options[:key] rescue nil
  		@secret = options[:secret] rescue nil 			
  	end

  	def get_accounts
  		response = rest_api("GET", "account", {})
  	end

    def get_account account_id
      response = rest_api("GET", "account/#{account_id}", {})
    end

    def get_balance account_id
      response = rest_api("GET", "balance/#{account_id}", {})
    end

    def get_txn ticker, tx_hash
      response = rest_api("GET", "transaction/asset_ticker/#{ticker.upcase}/hash/#{tx_hash}", {})
    end

    def get_txn_ac account_id, start_time, end_time
      response = rest_api("GET", "transaction/account_id/#{account_id}/start_time/#{start_time}/end_time/#{end_time}", {})
    end

    def create_deposit body
      response = rest_api("post", "deposit", body)
    end

    def cancel_deposit request_id
      response = rest_api("DELETE", "deposit/#{request_id}", {})
    end

    def get_deposit request_id
      response = rest_api("GET", "deposit/#{request_id}", {})
    end

    def create_withdraw body
      response = rest_api("post", "withdraw", body)
    end

    def cancel_withdraw request_id
      response = rest_api("DELETE", "withdraw/#{request_id}", {})
    end

    def get_withdraw request_id
      response = rest_api("GET", "withdraw/#{request_id}", {})
    end

    def subscribe_webhook
      response = rest_api("post", "webhook", body)
    end

    def get_subscriptions account_id
      response = rest_api("GET", "webhook/#{account_id}", {})
    end

    def delete_subscription uuid
      response = rest_api("DELETE", "webhook/#{uuid}", {})
    end

  	protected	
  	
  	def rest_api(verb, path, body = nil)
  		verb = verb.upcase
      body_digest = nil
      timestamp = new_timestamp.to_s + "0000"
      request_line = verb + ' ' + base_url+path + ' HTTP/1.1'
      if body
        if non_get_verb? verb
          body_digest = Base64.strict_encode64(digest(JSON.generate(body)))
        end
      end
      signature = encode_hmac_512(timestamp, host, request_line, body_digest)
      url = host+base_url+path

      if ['POST', 'PUT', 'PATCH', 'DELETE'].include?(verb)
        authorization = "hmac username=\"" + key + "\", algorithm=\"hmac-sha512\", headers=\"nonce host digest request-line\", signature=\"" + signature + "\""
      else
        authorization = "hmac username=\"" + key + "\", algorithm=\"hmac-sha512\", headers=\"nonce host request-line\", signature=\"" + signature + "\"";
      end
      if is_get? verb
        response = Faraday.get(url) do |req|
          req.headers['nonce'] = timestamp.to_s
          req.headers['authorization'] = authorization
          req.headers['Date'] = http_format_date
          req.headers['Content-Type'] = 'application/json'
          req.headers['Accept'] = 'application/json'
        end
      elsif non_get_verb? verb
        response = Faraday.post(url) do |req|
          req.body = body.compact.to_json
          req.headers['nonce'] = timestamp.to_s
          req.headers['digest'] = "SHA-256="+body_digest
          req.headers['authorization'] = authorization
          req.headers['Date'] = http_format_date
          req.headers['Content-Type'] = 'application/json'
        end
      end
      JSON.parse(response.body)
  	end
  	
  	private
  	
		def base_url
      return "/hexsafe/api/v4/"
    end

    def host
    	return "Invalid Environment" unless %w(TEST MAIN).include?(@mode)
    	@mode == "TEST" ? "https://api-test.hexsafe.io" : "https://api.hexsafe.io"
    end

    def key
      @key ||= @key
    end

    def secret
      @secret ||= @secret
    end

    def digest(data)
      sha256 = OpenSSL::Digest::SHA256.new()
      sha256.digest(data.encode('utf-8'))
    end

    def hmac_512 (secret, data)
      OpenSSL::HMAC.digest('sha512',secret, data)
    end

    def encode_hmac_512(timestamp, host, request_line, body_digest = nil)
      data = ''
      data << 'nonce: ' + timestamp.to_s + "\n"
      data << 'host: ' + URI.parse(host).host + "\n"
      if body_digest
        data << 'digest: SHA-256=' + body_digest + "\n"
      end
      data << request_line
      Base64.strict_encode64(hmac_512(secret,data))
    end

		def http_format_date
      Time.now.httpdate
    end
    
    def new_timestamp
      (Time.now.to_f*1000).to_i.to_s
    end

    def is_get? verb
      return ['GET'].include?(verb)
    end

    def non_get_verb? verb
      return ['POST', 'PUT', 'PATCH', 'DELETE'].include?(verb)
    end
  end 
end