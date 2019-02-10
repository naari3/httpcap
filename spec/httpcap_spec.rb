# frozen_string_literal: true

RSpec.describe HTTPcap do
  it 'has a version number' do
    expect(HTTPcap::VERSION).not_to be nil
  end

  describe 'self.http_connections' do
    subject { HTTPcap.http_connections(file_path) }
    let(:file_path) { fixture_path('test.pcap') }

    it 'returns HTTPFlow' do
      expect(subject).to all(satisfy { |http| http.is_a? HTTPcap::HTTPFlow })
    end
  end
end
