#!/bin/sh
# CREDIT: https://github.com/shawwn/scrap/blob/master/gwern-pages
gwern-sitemap | rg -v 'gwern.net/.*[.]' | rg -v gwern.net/docs | rg -v gwern.net/tags
