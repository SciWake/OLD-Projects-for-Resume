import scrapy


class ZillowSpider(scrapy.Spider):
    name = 'zillow'
    allowed_domains = ['www.zillow.com']
    start_urls = ['http://www.zillow.com/']

    def parse(self, response):
        pass
