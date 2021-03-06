# frozen_string_literal: true

module NobelPrize
  class NetworkError < StandardError
  end

  class Client
    def initialize; end

    def prizes(offset = 0)
      response = conn.get('nobelPrizes', { offset: offset, limit: 25 })
      parse_prizes(JSON.parse(response.body)['nobelPrizes'])
    rescue Faraday::ConnectionFailed => e
      Rails.logger.error e.message.to_s
      raise NetworkError, e.message
    end

    def laureates(offset = 0)
      response = conn.get('laureates', { offset: offset, limit: 25 })
      parse_laureates(JSON.parse(response.body)['laureates'])
    rescue Faraday::ConnectionFailed => e
      Rails.logger.error e.message.to_s
      raise NetworkError, e.message
    end

    def thumbnail(id)
      response = conn.get("https://www.nobelprize.org/laureate/#{id}")

      return parsed_pictures(response).first if parsed_pictures(response).present?

      parsed_figures(response).first
    end

    def parsed_pictures(response)
      Nokogiri::HTML.parse(response.body).css('article.facts picture source').map do |s|
        s['data-srcset']
      end
    end

    def parsed_figures(response)
      Nokogiri::HTML.parse(response.body).css('article.result figure img').map do |s|
        s['src']
      end
    end

    def self.prizes(offset = 0)
      instance.prizes(offset)
    end

    def self.laureates(offset = 0)
      instance.laureates(offset)
    end

    def self.thumbnail(id)
      instance.thumbnail(id)
    end

    def self.instance
      @instance ||= new
    end

    private

    def parse_prizes(prizes_attrs)
      prizes_attrs.map { |prize_attrs| Prize.parse(prize_attrs) }
    end

    def parse_laureates(laureates_attrs)
      laureates_attrs.map { |laureate_attrs| Laureate.parse(laureate_attrs) }
    end

    def conn
      @conn ||= Faraday.new(
        url: 'https://api.nobelprize.org/2.1/',
        headers: { 'Content-Type' => 'application/json' }
      ) do |f|
        f.use Faraday::Response::RaiseError
        f.use FaradayMiddleware::FollowRedirects
      end
    end
  end
end
