import scrapy
import json
from scrapy.loader import ItemLoader
from zillowparse.items import ZillowparseItem

class ZillowSpider(scrapy.Spider):
    name = 'zillow'
    allowed_domains = ['www.zillow.com']
    start_urls = ['https://www.zillow.com/homes/San-Francisco/']

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
        item.add_value('price', property['price'])
        item.add_value('url', response.url)
        item.add_value('state', property['address']['state'])
        item.add_value('city', property['address']['city'])
        item.add_value('streetAddress', property['address']['streetAddress'])
        item.add_value('zipcode', property['address']['zipcode'])
        item.add_value('bedrooms', property['resoFacts']['bedrooms'])
        item.add_value('bathrooms', property['resoFacts']['bathrooms'])
        item.add_value('bathroomsFull', property['resoFacts']['bathroomsFull'])
        item.add_value('heating', property['resoFacts']['heating'])
        item.add_value('hasHeating', property['resoFacts']['hasHeating'])
        item.add_value('laundryFeatures', property['resoFacts']['laundryFeatures'])
        item.add_value('fireplaces', property['resoFacts']['fireplaces'])
        item.add_value('fireplaceFeatures', property['resoFacts']['fireplaceFeatures'])
        item.add_value('parkingFeatures', property['resoFacts']['parkingFeatures'])
        item.add_value('garageSpaces', property['resoFacts']['garageSpaces'])
        item.add_value('hasAttachedGarage', property['resoFacts']['hasAttachedGarage'])
        item.add_value('hasCarport', property['resoFacts']['hasCarport'])
        item.add_value('homeType', property['resoFacts']['homeType'])
        item.add_value('hasPetsAllowed', property['resoFacts']['hasAssociation'])
        item.add_value('taxAssessedValue', property['resoFacts']['taxAssessedValue'])
        item.add_value('taxAnnualAmount', property['resoFacts']['taxAnnualAmount'])
        item.add_value('specialListingConditions', property['resoFacts']['specialListingConditions'])
        item.add_value('yearBuilt', property['yearBuilt'])
        item.add_value('longitude', property['longitude'])
        item.add_value('latitude', property['yearBuilt'])
        item.add_value('description', property['description'])
        item.add_value('livingArea', property['livingArea'])
        item.add_value('solarSunScore', property['solarPotential']['sunScore'])
        item.add_value('solarBuildFactor', property['solarPotential']['buildFactor'])
        item.add_value('solarClimateFactor', property['solarPotential']['climateFactor'])
        item.add_value('solarElectricityFactor', property['solarPotential']['electricityFactor'])
        item.add_value('solarFactor', property['solarPotential']['solarFactor'])
        item.add_value('mortgageRates_thirtyYearFixedRate', property['mortgageRates']['thirtyYearFixedRate'])
        item.add_value('mortgageRates_fifteenYearFixedRate', property['mortgageRates']['fifteenYearFixedRate'])
        item.add_value('mortgageRates_arm5Rate', property['mortgageRates']['arm5Rate'])
        item.add_value('propertyTaxRate', property['propertyTaxRate'])
        item.add_value('schools', property['schools'])

        url_photos = [photo['mixedSources']['jpeg'][-1]['url'] for photo in property['responsivePhotosOriginalRatio']]
        item.add_value('photos', url_photos)

        yield item.load_item()
