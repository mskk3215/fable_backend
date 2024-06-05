# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Health API' do
  describe 'GET /api/v1/health' do
    context 'エンドポイントにアクセスした時' do
      it 'ステータスokを返す' do
        get api_v1_health_path

        expect(response).to have_http_status(:ok)
        expect(json).to eq({ 'status' => 'ok' })
      end
    end

    context 'エラーが発生した場合' do
      before do
        allow(ActiveRecord::Base.connection).to receive(:execute).and_raise(StandardError, 'some error')
      end

      it 'エラーステータスとメッセージを返す' do
        get api_v1_health_path

        expect(response).to have_http_status(:internal_server_error)
        expect(json).to eq({ 'status' => 'error', 'error' => 'some error' })
      end
    end
  end
end
