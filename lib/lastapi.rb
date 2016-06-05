#!usr/bin/env ruby

require 'optparse'
require 'yaml'
require 'highline/import'
require 'byebug'
require 'lastpass'

require_relative 'lastapi/lastapi'
require_relative 'lastapi/accounts_cache'
require_relative 'lastapi/accounts'

Lastapi.startup
