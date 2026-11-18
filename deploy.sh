#!/bin/env bash

rsync -avz --delete --chmod=D755,F644 public/ webmaster@latte:/var/www/site
