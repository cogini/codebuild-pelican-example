#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

SITETITLE = 'CodeBuild Pelican Example'
SITENAME = u"CodeBuild Pelican Example"
SITEURL = ''
# SITEURL = 'https://www.example.com'

AUTHOR = u'Jake Morrison'

# GITHUB_URL = 'https://github.com/ejmorrison16'

TWITTER_NAME = 'example'
FACEBOOK_NAME = 'example'
INSTAGRAM_NAME = 'example'
# FACEBOOK_APPID = '123'
GOOGLE_ANALYTICS = 'UA-XXX-XX'

SITESUBTITLE = 'Lorem ipsum'
SITEDESCRIPTION = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'

SITELOGO = SITEURL + '/images/logo.png'
FAVICON = SITEURL + '/images/favicon.ico'

BROWSER_COLOR = '#333'
ROBOTS = 'index, follow'

# COPYRIGHT_YEAR = 2019

MAIN_MENU = True

PATH = 'content'
PLUGIN_PATHS = ['plugins']
# PLUGINS = ["pelican_alias", 'sitemap']
STATIC_PATHS = ['images', 'extra', 'files', 'share']
ARTICLE_EXCLUDES = ['extra']

# Point to the theme directory subdir
# THEME = 'theme'

# Call a theme by class
THEME = 'notmyidea'
# THEME = 'simple'

TIMEZONE = 'US/Pacific'
DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
# FEED_DOMAIN = SITEURL
# FEED_ATOM = 'feeds/atom.xml'
FEED_ATOM = None
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

SITEMAP = {
    'format': 'xml',
    'priorities': {
        'articles': 0.6,
        'indexes': 0.6,
        'pages': 0.5,
    },
    'changefreqs': {
        'articles': 'daily',
        'indexes': 'daily',
        'pages': 'monthly',
    },
    'exclude': ['tag/', 'category/']
}

# global metadata to all the contents
# DEFAULT_METADATA = {'yeah': 'it is'}

EXTRA_PATH_METADATA = {
    'images/favicon.ico': {'path': 'favicon.ico'},
    'extra/robots.txt': {'path': 'robots.txt'},
    # This is how you put a file in the root directory to validate control of
    # the domain for google
    # 'extra/google700c1f01b6b0e74c.html': {'path': 'google700c1f01b6b0e74c.html'},
    'extra/custom.css': {'path': 'static/custom.css'},
}
CUSTOM_CSS = 'static/custom.css'

# TEMPLATE_PAGES = {'content/pages/books.html': 'dest/books.html',
#                   'src/resume.html': 'dest/resume.html',
#                   'src/contact.html': 'dest/contact.html'}

INDEX_SAVE_AS = 'blog/index.html'
ARTICLE_URL = 'blog/{slug}/'
ARTICLE_SAVE_AS = 'blog/{slug}/index.html'
PAGE_URL = '{slug}/'
PAGE_SAVE_AS = '{slug}/index.html'

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
# RELATIVE_URLS = True
