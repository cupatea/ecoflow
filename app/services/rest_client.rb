class RestClient
  HOST           = "https://api-e.ecoflow.com"
  ALL_QUOTA_PATH = "/iot-open/sign/device/quota/all"

  attr_reader :profile

  delegate :access_key, :secret_key, to: :profile


  def initialize(profile)
    @profile = profile
  end

  def all_quota(device)
    response = conn.get(ALL_QUOTA_PATH, { sn: device.sn })
    if response.success?
      JSON.parse(response.body).dig("data")
    else
      {}
    end
  end

  private

  def gen_nonce
    Random.new.rand(10000..99999).to_s
  end

  def get_timestamp
    Time.now.utc.to_datetime.strftime("%Q")
  end

  def sign(params, timestamp, nonce)
    OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new("sha256"),
      secret_key,
      params.merge(accessKey: access_key, nonce: nonce, timestamp: timestamp).to_query
    )
  end

  def conn(params = {})
    timestamp = get_timestamp
    nonce     = gen_nonce
    Faraday.new(
      url: HOST,
      params: params,
      headers: {
        "Content-Type" => "application/json",
        "accessKey"    => access_key,
        "timestamp"    => timestamp,
        "nonce"        => nonce,
        "sign"         => sign(params, timestamp, nonce)
      },
    )
  end
end
