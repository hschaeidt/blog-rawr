+++
title = "Jest & Enzyme Snapshot Testing"
date = "2016-12-16T21:24:04+01:00"

+++

# Enzyme and snapshots in harmony

Lately I've been playing around with [jests](https://facebook.github.io/jest/) [Snapshot Testing](https://facebook.github.io/jest/index.html#react-react-native-and-snapshot-testing)
after having manually set-up similar UI-tests with [enzyme](http://airbnb.io/enzyme/). I must admit it's quite comfortable to use.<br />
<br />
My approach was using the `react-test-renderer` directly. Well, obviously this has some pitfalls when testing with enzyme
and snapshots within the same testfile. A component can't be mounted or shallowed twice, so [my workaround](https://github.com/hschaeidt/react-timer-app/blob/d8d583de58474ba00325ce07bd1bf51de93fadf0/app/components/tracker/__tests__/TrackerItem-test.jsx) was to create 2 different
test setup helpers instead of one returning both: the tree and the wrapper.<br />
<br />
This will be a short story: The solution is simple, as [enzyme just uses the TestUtils renderer](https://github.com/airbnb/enzyme/blob/master/src/react-compat.js#L30)
in the background  as I was using manually it's quite obvious what to do.<br />
<br />
We can just go and call `getNodes()` on our wrapper and it's compatible with our `toMatchSnapshot()` function. This [gist](https://gist.github.com/hschaeidt/0534e948aa8e101f665e9a5d5931bf27)
shows a quick example of the idea.<br />