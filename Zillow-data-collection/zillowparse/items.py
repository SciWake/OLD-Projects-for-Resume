# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy
from scrapy.loader.processors import MapCompose, TakeFirst


class ZillowparseItem(scrapy.Item):
    id = scrapy.Field(output_processor=TakeFirst())
    url = scrapy.Field(output_processor=TakeFirst())
    state = scrapy.Field(output_processor=TakeFirst())
    city = scrapy.Field(output_processor=TakeFirst())
    streetAddress = scrapy.Field(output_processor=TakeFirst())
    zipcode = scrapy.Field(output_processor=TakeFirst())
    bedrooms = scrapy.Field(output_processor=TakeFirst())
    bathrooms = scrapy.Field(output_processor=TakeFirst())
    yearBuilt = scrapy.Field(output_processor=TakeFirst())
    isPremierBuilder = scrapy.Field(output_processor=TakeFirst())
    longitude = scrapy.Field(output_processor=TakeFirst())
    latitude = scrapy.Field(output_processor=TakeFirst())

    photos = scrapy.Field()
