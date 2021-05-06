# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy
from scrapy.loader.processors import MapCompose, TakeFirst


class ZillowparseItem(scrapy.Item):
    id = scrapy.Field(input_processor=MapCompose(lambda data: int(data[2:])), output_processor=TakeFirst())
    url = scrapy.Field(output_processor=TakeFirst())
    title = scrapy.Field(output_processor=TakeFirst())
    photos = scrapy.Field()
