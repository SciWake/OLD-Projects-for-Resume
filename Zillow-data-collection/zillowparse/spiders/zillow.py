import scrapy

class ZillowSpider(scrapy.Spider):
    name = 'zillow'
    allowed_domains = ['www.zillow.com']
    start_urls = ['https://www.zillow.com/homes/Washington_rb/']

    def parse(self, response):
        # Getting pagination links
        for pag_url in response.xpath('//nav[@aria-label="Pagination"]//a[@title="Next page"]/@href'):
            yield response.follow(pag_url, callback=self.parse)
