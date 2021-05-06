# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy
from scrapy.loader.processors import MapCompose, TakeFirst


def select_data(data):
    data.pop('atAGlanceFacts')
    return data

class ZillowparseItem(scrapy.Item):
    id = scrapy.Field(output_processor=TakeFirst())
    url = scrapy.Field(output_processor=TakeFirst())
    state = scrapy.Field(output_processor=TakeFirst())
    city = scrapy.Field(output_processor=TakeFirst())
    streetAddress = scrapy.Field(output_processor=TakeFirst())
    zipcode = scrapy.Field(output_processor=TakeFirst())
    bedrooms = scrapy.Field(output_processor=TakeFirst())
    bathrooms = scrapy.Field(output_processor=TakeFirst())
    bathroomsFull = scrapy.Field(output_processor=TakeFirst())
    basement = scrapy.Field(output_processor=TakeFirst())
    bathroomsThreeQuarter = scrapy.Field(output_processor=TakeFirst())
    bathroomsOneQuarter = scrapy.Field(output_processor=TakeFirst())
    heating = scrapy.Field(output_processor=TakeFirst())
    hasHeating = scrapy.Field(output_processor=TakeFirst())
    cooling = scrapy.Field(output_processor=TakeFirst())
    laundryFeatures = scrapy.Field(output_processor=TakeFirst())
    fireplaces = scrapy.Field(output_processor=TakeFirst())
    fireplaceFeatures = scrapy.Field(output_processor=TakeFirst())
    furnished = scrapy.Field(output_processor=TakeFirst())
    aboveGradeFinishedArea = scrapy.Field(output_processor=TakeFirst())
    parkingFeatures = scrapy.Field(output_processor=TakeFirst())
    garageSpaces = scrapy.Field(output_processor=TakeFirst())
    coveredSpaces = scrapy.Field(output_processor=TakeFirst())
    hasAttachedGarage = scrapy.Field(output_processor=TakeFirst())
    openParkingSpaces = scrapy.Field(output_processor=TakeFirst())
    carportSpaces = scrapy.Field(output_processor=TakeFirst())
    hasCarport = scrapy.Field(output_processor=TakeFirst())
    otherParking = scrapy.Field(output_processor=TakeFirst())
    spaFeatures = scrapy.Field(output_processor=TakeFirst())
    hasWaterfrontView = scrapy.Field(output_processor=TakeFirst())
    parcelNumber = scrapy.Field(output_processor=TakeFirst())
    hasAttachedProperty = scrapy.Field(output_processor=TakeFirst())
    homeType = scrapy.Field(output_processor=TakeFirst())
    numberOfUnitsInCommunit = scrapy.Field(output_processor=TakeFirst())
    hasPetsAllowed = scrapy.Field(output_processor=TakeFirst())
    hasAssociation = scrapy.Field(output_processor=TakeFirst())
    taxAssessedValue = scrapy.Field(output_processor=TakeFirst())
    taxAnnualAmount = scrapy.Field(output_processor=TakeFirst())
    specialListingConditions = scrapy.Field(output_processor=TakeFirst())
    buyerAgencyCompensation = scrapy.Field(output_processor=TakeFirst())
    propertySubType = scrapy.Field(output_processor=TakeFirst())
    yearBuilt = scrapy.Field(output_processor=TakeFirst())
    longitude = scrapy.Field(output_processor=TakeFirst())
    latitude = scrapy.Field(output_processor=TakeFirst())
    description = scrapy.Field(output_processor=TakeFirst())
    livingArea = scrapy.Field(output_processor=TakeFirst())


    photos = scrapy.Field()
