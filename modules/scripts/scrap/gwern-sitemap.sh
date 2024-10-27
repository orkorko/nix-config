#!/bin/sh
# CREDIT: https://github.com/shawwn/scrap/blob/master/gwern-sitemap
curl -fsSL gwern.net/sitemap.xml | rg '(http.*?)<' -o --replace '$1'
