# Flickr App

##  Dependancies
**SDWebImage** I chose to use just the one third party library. The reason for this is it would've taken me a considerable amount of time to write an image caching library myself and would've taken time away from focussing on the requirements of the task. This library is one among others such as Kingfisher which I have used in the past and is one I am familiar with.

## Decisions
**Carthage** I chose to use Carthage as I am a fan of using a decentralised non-intrusive method of bringing in third party tools.

**Storyboards** Normally i would use a mixture between Storyboards/UINib and creating UI via code however for the purpose of this test I went full Interface Builder as it seems these days thats the way that Apple is heading.

**Layout** I would like to have just used size classes to determine how many columns I would have, but sadly the only regular width iPhones are the 6plus/7plus/8plus and even though the iPhone X certainly has enough room on landscape, using size classes alone would not produce the 2 column output I wanted. As a result I had to check `UIDevice.current.orientation`

**No RXSwift** Despite the spec for the test allowing the use of RXSwift, this is not something I have had production experience with, and is something I am currently learning so I didnt see it fit that I would complete the test in something which may not be production quality.

**Added UIRefreshControl** I added pull to refresh as it is a commonly used iOS design pattern and an easy way to refresh the UI even though it was not asked for in the spec

## Tasks Completed
- Core Requirements
- Share
- Image caching (via SDWebImage)
- Ordering by date taken or date published

