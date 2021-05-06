# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy
from scrapy.loader.processors import MapCompose, TakeFirst


class ZillowparseItem(scrapy.Item):
    id = scrapy.Field(output_processor=TakeFirst())
    id = scrapy.Field(output_processor=TakeFirst())
    price = scrapy.Field(output_processor=TakeFirst())
    url = scrapy.Field(output_processor=TakeFirst())
    state = scrapy.Field(output_processor=TakeFirst())
    city = scrapy.Field(output_processor=TakeFirst())
    streetAddress = scrapy.Field(output_processor=TakeFirst())
    zipcode = scrapy.Field(output_processor=TakeFirst())
    bedrooms = scrapy.Field(output_processor=TakeFirst())
    bathrooms = scrapy.Field(output_processor=TakeFirst())
    bathroomsFull = scrapy.Field(output_processor=TakeFirst())
    bathroomsThreeQuarter = scrapy.Field(output_processor=TakeFirst())
    bathroomsOneQuarter = scrapy.Field(output_processor=TakeFirst())
    heating = scrapy.Field(output_processor=TakeFirst())
    hasHeating = scrapy.Field(output_processor=TakeFirst())
    laundryFeatures = scrapy.Field(output_processor=TakeFirst())
    fireplaces = scrapy.Field(output_processor=TakeFirst())
    fireplaceFeatures = scrapy.Field()
    furnished = scrapy.Field(output_processor=TakeFirst())
    parkingFeatures = scrapy.Field(output_processor=TakeFirst())
    garageSpaces = scrapy.Field(output_processor=TakeFirst())
    coveredSpaces = scrapy.Field(output_processor=TakeFirst())
    hasAttachedGarage = scrapy.Field(output_processor=TakeFirst())
    openParkingSpaces = scrapy.Field(output_processor=TakeFirst())
    carportSpaces = scrapy.Field(output_processor=TakeFirst())
    hasCarport = scrapy.Field(output_processor=TakeFirst())
    spaFeatures = scrapy.Field()
    homeType = scrapy.Field(output_processor=TakeFirst())
    hasPetsAllowed = scrapy.Field(output_processor=TakeFirst())
    taxAssessedValue = scrapy.Field(output_processor=TakeFirst())
    taxAnnualAmount = scrapy.Field(output_processor=TakeFirst())
    specialListingConditions = scrapy.Field(output_processor=TakeFirst())
    buyerAgencyCompensation = scrapy.Field(output_processor=TakeFirst())
    yearBuilt = scrapy.Field(output_processor=TakeFirst())
    longitude = scrapy.Field(output_processor=TakeFirst())
    latitude = scrapy.Field(output_processor=TakeFirst())
    description = scrapy.Field(output_processor=TakeFirst())
    livingArea = scrapy.Field(output_processor=TakeFirst())

    solarSunScore = scrapy.Field(output_processor=TakeFirst())
    solarBuildFactor = scrapy.Field(output_processor=TakeFirst())
    solarClimateFactor = scrapy.Field(output_processor=TakeFirst())
    solarElectricityFactor = scrapy.Field(output_processor=TakeFirst())
    solarFactor = scrapy.Field(output_processor=TakeFirst())
    mortgageRates_thirtyYearFixedRate = scrapy.Field(output_processor=TakeFirst())
    mortgageRates_fifteenYearFixedRate = scrapy.Field(output_processor=TakeFirst())
    mortgageRates_arm5Rate = scrapy.Field(output_processor=TakeFirst())
    propertyTaxRate = scrapy.Field(output_processor=TakeFirst())
    schools = scrapy.Field()

    photos = scrapy.Field()
