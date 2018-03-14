# Flickr App 
[![Build Status](https://travis-ci.org/wilkinsonjack/Flickr.svg?branch=master)](https://travis-ci.org/wilkinsonjack/Flickr)

##  Dependencies
**SDWebImage** I chose to use just the one third party library. The reason for this is it would've taken me a considerable amount of time to write an image caching library myself and would've taken time away from focussing on the requirements of the task. This library is one among others such as Kingfisher which I have used in the past and is one I am familiar with.

## Decisions
**Carthage** I chose to use Carthage as I am a fan of using a decentralised non-intrusive method of bringing in third party tools. I also decided to check in the `Carthage/Build` directory in order to prevent any issues where SDWebImage might change by some coincidence as well as if the reviewer does not have `Carthage` installed on their machine. Normally I would not do this as it would unnecessarily increase the repo size.

**Storyboards** Normally i would use a mixture between Storyboards/UINib and creating UI via code however for the purpose of this test I went full Interface Builder as it seems these days thats the way that Apple is heading.

**SFSafariViewController** I chose to use `SFSafariViewController` to open the url for the photo as it allows the user have the benefits of Safari (such as Keychain and Reading List) whilst also being part of the app rather than opening a URL and leaving the app completely.

**Layout** I would like to have just used size classes to determine how many columns I would have, but sadly the only regular width iPhones are the 6plus/7plus/8plus and even though the iPhone X certainly has enough room on landscape, using size classes alone would not produce the 2 column output I wanted. As a result I had to check `UIDevice.current.orientation`

**No RXSwift** Despite the spec for the test allowing the use of RXSwift, this is not something I have had production experience with, and is something I am currently learning so I didnt see it fit that I would complete the test in something which may not be production quality.

**Added UIRefreshControl** I added pull to refresh as it is a commonly used iOS design pattern and an easy way to refresh the UI even though it was not asked for in the spec

**TravisCI** Added TravisCI as a means of Continuous Integration. In order to check things dont just work on my machine

## Tasks Completed
- Core Requirements
- Share
- Image caching (via SDWebImage)
- Open in browser
- Ordering by date taken or date published

