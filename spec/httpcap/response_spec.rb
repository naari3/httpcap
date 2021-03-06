# frozen_string_literal: true

RSpec.describe HTTPcap::Response do
  subject(:response) { HTTPcap::Response.new(http_response) }

  let(:http_response) { "HTTP/1.1 #{http_status} OK\r\n#{headers.map { |k, v| "#{k}: #{v}" }.join("\r\n")}\r\n\r\n#{body}" }
  let(:http_status) { 200 }
  let(:headers) do
    {
      'Content-Type' => 'text/plain',
      'Content-Length' => body.size
    }
  end
  let(:host) { 'www.example.com' }
  let(:body) { 'hello, this is a test code.' }

  it 'receive raw http response' do
    subject
    expect(response.body).to eq body
    expect(response.http_status).to eq http_status
    headers.keys do |k|
      expect(response.headers[k]).to eq headers[k]
    end
  end
end
