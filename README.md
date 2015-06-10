![bongo](https://raw.githubusercontent.com/voxmedia/bongo/master/app/assets/images/logo.png)

Bongo is a responsive tool that quickly enables people to make type pairings, color, branding and photo choices in a live, responsive environment without writing any code.

## Getting started


1.  Go to Typekit, set up a new kit with every font you want to test (maximum of 8). Grab the kit ID from the kit editor window.
Go to bongo.voxmedia.com, start a new project.
2.  Enter project info (name, logo, etc.), including the kit ID from step 1.
3.  Enter text for the project (perhaps pre-populated with lorem ipsum or some other placeholder text by default?), logo, images, etc.
4.  From the fonts in the selected kit, specify which ones to use for headlines, which ones for body text, which ones for pull quotes, etc.
5.  Save & publish project.
6.  Visit project page, use arrows to view different combinations of fonts.

## Documentation

TK

## Examples

TK

## Install on Heroku

```
bundle install --without production test
heroku create
git push heroku master
heroku run rake db:migrate
heroku open
```

## Authors

Ted Irvine, Josh Laincz, Guillermo Esteves, Georgia Cowley, Jason Ormand, Curtis Schiewek

## Contribute

This is an active project and we encourage contributions. [Please review our guidelines and code of conduct before contributing.](https://github.com/voxmedia/open-source-contribution-guidelines)
