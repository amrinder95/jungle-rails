class PagesController < ApplicationController
  http_basic_authenticate_with username: "Jungle", password: "book", only: :info

