import scrapy
import json
from scrapy.loader import ItemLoader
from zillowparse.items import ZillowparseItem
import time


class ZillowSpider(scrapy.Spider):
    name = 'zillow'
    allowed_domains = ['www.zillow.com']
    start_urls = ['https://www.zillow.com/homes/San-Francisco_rb/']

    def parse(self, response):
        # Getting pagination links
        for pag_url in response.xpath('//nav[@aria-label="Pagination"]//a[@title="Next page"]/@href'):
            yield response.follow(pag_url, callback=self.parse)

        # Getting links to apartments
        for house_url in response.xpath(
                "//ul[contains(@class, 'photo-cards_short')]/li/article/div[@class='list-card-info']/a/@href"):
            yield response.follow(house_url, callback=self.house_parse)

    @staticmethod
    def clear_data(item, data):
        data_json = json.loads(data)['apiCache']
        # We cut the first part of json to the right moment
        data_json = data_json[data_json.index('ForSaleDoubleScrollFullRenderQuery'):]

        index_end = data_json.index('{"property"')  # Cut off the beginning of the key to replace it with a new one
        data_json = '{"info":' + data_json[index_end:]  # Since we cut the first key, we will create a new one

        return json.loads(data_json)

    def house_parse(self, response):
        item = ItemLoader(ZillowparseItem(), response)
        data = self.clear_data(item, response.css("script#hdpApolloPreloadedData::text").extract()[0])

        property = data['info']['property']
        item.add_value('id', property['zpid'])
        item.add_value('url', response.url)
        item.add_value('state', property['address']['state'])
        item.add_value('city', property['address']['city'])
        item.add_value('streetAddress', property['adress']['streetAddress'])
        item.add_value('zipcode', property['adress']['zipcode'])

        item.add_value('bedrooms', property['bedrooms'])
        item.add_value('bathrooms', property['bathrooms'])
        item.add_value('yearBuilt', property['yearBuilt'])
        item.add_value('isPremierBuilder', property['isPremierBuilder'])
        item.add_value('longitude', property['longitude'])
        item.add_value('latitude', property['yearBuilt'])
        item.add_value('yearBuilt', property['yearBuilt'])




        print(1)
