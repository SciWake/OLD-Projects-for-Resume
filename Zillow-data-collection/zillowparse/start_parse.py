from scrapy.crawler import CrawlerProcess
from scrapy.settings import Settings
from zillowparse import settings
from zillowparse.spiders.zillow import ZillowSpider

if __name__ == '__main__':
    crawler_settings = Settings()
    crawler_settings.setmodule(settings)
    crawler_process = CrawlerProcess(settings=crawler_settings)
    crawler_process.crawl(ZillowSpider)
    crawler_process.start()