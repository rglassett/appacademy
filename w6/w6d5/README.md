# AJAX Twitter

First, run `rake db:create db:migrate db:seed` for the initial
database setup.

## Phase I: `FollowToggle`

We will write a jQuery plugin that turns a button into a toggle that
will follow/unfollow a user.

Look at `app/views/follows/_form.html.erb`. We want to replace the
contents of this form with a single button. Notice that there are two
branches of logic: the button will be a 'follow' button if the current
user is not yet following the user, and an 'unfollow' button if they
are.

Replace the form with a single `button`. We'll need to let the button
know the `user-id` and `initial-follow-state` ("followed" or
"unfollowed"): I stored these in `data-*` attributes. I also gave the
button a class of `follow-toggle`. I left the inner HTML of the button
empty: the jQuery plugin will be responsible for setting this.

Like all jQuery plugins, you should define it like so:

```js
$.FollowToggle = function (el) {
  // ...
};

$.FollowToggle.prototype.method1 = function () {
  // ...
};

$.fn.followToggle = function () {
  return this.each(function () {
    new $.FollowToggle(this);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
```

This will build a `FollowToggle` instance for each `follow-toggle`
button on the page.

Now let's start writing the code. In the constructor, extract the
`user-id` and `initial-follow-state` from `el` and save those in
instance variables `userId` and `followState` for later use. You might
also find it convenient to store a jQuery wrapped `el` as an instance
variable.

__NB: Though the follow state is stored in the Rails API as a boolean,
on the client side, we'll keep track of the follow state as a string.
This is because eventually we'll have more follow states (e.g.
"following") in addition to followed/unfollowed.__

Next, write a `FollowToggle#render` method. Depending on
`this.followState`, the text should be `"Follow!"` if
`this.followState == "unfollowed"`, and `"Unfollow!"` if
`this.followState == "followed"`.

Call your `#render` method inside the constructor to initially set the
inner HTML.

Next, write a `FollowToggle#handleClick` method. Install this click
handler in the constructor. Your click handler should:

0. Prevent the default action.
0. Make a `$.ajax` request to `POST` `/users/:id/follow` if we are not
   following the user (check `followState`).
0. Else, it should make a `DELETE` request.
0. On success of the `POST`/`DELETE`, we should toggle the
   `followState` and re-render.

Check to make sure this works! **Hint**: you probably want to use the
`dataType` `$.ajax` option.

Lastly, let's freeze-out the button so that people can't click it
while the AJAX request is pending. To do this, in `handleClick`, I
would set `followState` to `following` or `unfollowing` and call
`#render`. My `#render` method would set the `disabled` property
(using `$.fn.prop`) if `following`/`unfollowing`. I set the
disabled property to false if `followState` is
`followed`/`unfollowed`.

Check that everything works and call over your TA so that they can
check your work!

## Phase II: `UsersSearch`

Review `app/controllers/users_controller.rb` and
`app/views/users/search.html.erb`. We want to create real-time user
search. On every keypress as the user types in a username, we'll show
the matching users for the current input.

To do this, we'll write a `UsersSearch` plugin. Replace the entire
form with a `div` with class `users-search`. Add an input field for
the user to type the name. Also nested in the `div.users-search`, have
a `ul.users` for displaying results.

Next, begin writing the `UsersSearch` plugin. As before, automatically
build a `UsersSearch` for each `div.users-search`. Again, you might
find it convienent to store jQuery wrapped versions of the `el`, its
`input` and its `ul`. Also in the constructor, we'll be installing a
listener for the `input` event on the input tag.

Write a `UsersSearch#handleInput` handler. On each input event, make
an AJAX request to `/users/search`, sending the input's `val` as the
query parameter. You can send query parameters along with an `$.ajax`
call through the `data` option. Don't forget set the `dataType` option
as well.

When the AJAX call successfully returns a list of matching users, we
want to display those results in the `ul.users`. Write a method
`UsersSearch#renderResults` for your AJAX success handler. This should
first empty out `ul.users`. Then it should iterate through the fetched
array of users. For each result, it should use jQuery to build an `li`
containing an anchor tag linking to the user. Use the jQuery `append`
method to add each result to the `ul`.

Check that you can now interactively search users.

Last, we want to add follow toggle buttons for each of these results.
When building the `li` tags for each user, build a `button`, too. You
can call `#followToggle` on the button to setup the follow toggle.

You could make this work by setting data attributes on the button for
`user-id` and `initial-follow-state`. In this context, that's kind of
annoying. Instead, it is common to allow jQuery plugins to take
options. I modified my `FollowToggle` like so:

```js
$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  this.followState = this.$el.data("initial-follow-state") || options.followState;
  // ...
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};
```

See if this helps you set up the follow toggle.

## Phase III: `TweetCompose`

Write a `TweetCompose` plugin. First, change
`app/views/tweets/_form.html.erb`. Give the form a class
`tweet-compose`. Write a jQuery plugin that graphs this form and
installs itself.

In the `TweetCompose` constructor, install a `submit` event handler.
Write a `TweetCompose#submit` method that uses `serializeJSON` to
build JSON from the form contents and use `$.ajax` to submit the form.

As before, disable the form when the submit is made. You can't disable
a form, you have to disable all the inputs. To get all the inputs, use
jQuery's [`:input` pseudo-CSS selector][input-selector]. Make sure not
to disable your inputs until after you've serialized the form
contents.

[input-selector]: http://api.jquery.com/input-selector

Write a `TweetCompose#clearInput` method to empty out all the inputs
after a tweet is successfully created. Write a
`TweetCompose#handleSuccess` method. This should call `clearInput` and
re-enable the form.

Next, let's add a counter that will show the number of characters
remaining for a tweet (starting at 140). Add a `strong` tag with class
`.chars-left` to the form. In the `TweetCompose` constructor, add an
`input` event handler on the `textarea`. In it, update the `strong`
tag with the number of characters remaining.

Lastly, let's finish writing `#handleSuccess` so that it inserts the
created tweet into the list of all tweets. How does `TweetCompose`
find the `ul` of tweets? We can set a data attribute on the form where
the value is the selector that corresponds to the target `ul`. For
example, if we give the target `ul` an id of `#feed`, we can give our
form the following data attribute: `data-tweets-ul="#feed"`. Our
`TweetCompose` can pull out this data attribute and use the selector
`#feed` to find the ul. This is better than hard coding `#feed` into
the JS.

A successful AJAX post request for a tweet should return back the
newly created tweet in json format. For simplicity, have
`TweetCompose` call `JSON.stringify` on the created Tweet. Build an
`li` with the JSON content, and stick it in the `ul`. We'll actually
render this nicely in a later phase.

Call your TA over to check your work!

## Phase IV: `TweetCompose`: Mentioned Users

The next part is to allow us to tag multiple users in a tweet. Right
now we can select a single user to tag. Our killer feature will be to
dynamically create more select tags so we can create more users.

Rather than have just one select tag visible all the time, we want to
have no select tags to start. Instead, we want to show an "Add
mention" link which will let us add multiple select tags to the page.

To do this, first move the `select` tag into a `<script
type="text/template">` tag. This tells the browser not to put the
`select` in the DOM. If you reload, you should see no select tag.

Write an "Add mention" anchor tag. Give it a phony href
(`href="javascript:void(0)"` is typical). Also give it a class
`add-mentioned-user`. I also added a `div.mentioned-users` that will
house all these newly generated select tags.

In the `TweetCompose` constructor, add a listener for a click on
`a.add-mentioned-user`. I wrote a `TweetCompose#addMentionedUser`
method. I used jQuery to find the `script` tag, I grabbed the HTML
from within using `$scriptTag.html()`, then appended it into the
`mentioned-users` div.

Test this out and make sure you can create new `select` tags by
clicking the link.

Next, I also want to be able to **remove** select tags. Say we clicked
"add" accidentally and want to remove the `select`. To do this, I
modified the script template slightly. I put the `select` in a `div`.
In the same div, I wrote an anchor tag with class
`remove-mentioned-user`. I gave it a similar bogus `href` attribute.

In the `TweetCompose` constructor, I listened for `click` events on
`a.remove-mentioned-user`. **You have to use event delegation here:
why?** I wrote a `TweetCompose#removeMentionedUser` which used the
`event.currentTarget` to learn which remove anchor tag was clicked,
and removed the parent `div` element. This removes both the anchor tag
and the select, too.

Check that this is working.

Lastly, we want to update `TweetCompose#clearInput` to clear out all
the selects after form submission succeeds. You should have been
putting all your select tags into a div with class `.mentioned-users`.
In `#clearInput`, I grab this div and `empty()` it.

## Phase V: Infinite Tweets

Right now we send all the tweets down when the user requests `/feed`.
If there are many, many tweets in the feed, this will send a huge
amount of data to the user. Moreover, the user is likely to be
interested in only the most recent tweets.

Let's **paginate** the sending of tweets. To start, open up
`app/models/user.rb`. Modify the `#feed_tweets` method to send only up
to `limit` tweets. Also, modify it not to return any tweets created
after `max_created_at`. Test this out in your Rails console before
moving to the JavaScript portion.

Next, let's begin modifying the `app/views/feeds/show.html.erb`
template. You should have a `ul#feed` from phase III. Wrap that `ul`
with a `div` with class `infinite-tweets`. You can empty out the
contents of the `ul#feed` since we'll be adding the tweets inside
dynamically with jQuery now. Also, write an anchor tag with class
`fetch-more`; this link will be clicked to load more tweets.

Begin writing an `InfiniteTweets` plugin. Listen for clicks to fetch
more; begin writing an `InfiniteTweets#fetchTweets` method.

In `#fetchTweets`, make an AJAX request to `/feed`. In the success
handler, call an `#insertTweets` method. For simplicity, for each
tweet, just append `<li>` items with `JSON.stringify(tweet)` into the
appropriate `ul`.

If you click the link twice, you'll fetch the same set of tweets
twice. We need to send the `max_created_at` parameter. In the
`InfiniteTweets` constructor, start `this.maxCreatedAt` at `null`. In
the `#fetchTweets` method, if `maxCreatedAt != null`, send it in the
AJAX `data` parameter. (Notice the often confusing mix of Ruby and JS
naming conventions).

When successfully fetching tweets, record `max_created_at` by looking
at the `created_at` attribute of the last tweet fetched. This should
ensure that each call to `#fetchTweets` fetches the next set of
tweets, chronologically.

Once you've fetched all the tweets, you should remove the "Fetch more
tweets" link and replace it with a message that there are no more
tweets to fetch. You can tell there are no more tweets to fetch if `<
20` tweets are returned.

## Phase VII: Underscore Templates

When we fetch the tweets, we want to not just stick the JSON
representation in; we want to render a partial to insert HTML into the
page.

In theory, we could build HTML in JavaScript. This would be tortuous
as the HTML got more sophisticated. Just like we use ERB in Ruby,
we'll use another templating language called Underscore templates in
JavaScript. Download the underscore.js library. One option for doing so
is the [underscore-rails gem][underscore_rails].

In your `div.infinite-tweets`, make a `<script type="text/template">`
as before. Inside here, write an Underscore template that iterates
through a `tweets` array, building one `li` for each. This is a lot
like Ruby, except:

```
<% tweets.each do |tweet| %>
  ...
<% end %>

VS.

<% tweets.forEach(function (tweet) { %>
  ...
<% }); %>
```

But don't forget to use double-percents (`%%`) so ERB doesn't try
to interpret your Underscore template code as Ruby. See
[this example][underscore_erb] for a refresher on how this works.

As you did for `TweetCompose`, have your `InfiniteTweets` find the
template and extract it. Modify the `#insertTweets` method. Take the
template code and pass it to the `_.template` method, which will build
a function from your Underscore template code. Call the compiled
template function, passing in `{ tweets: tweets }`, which makes the
tweets variable available to the template. Insert the rendered partial.

Check that this works. Call your TA over to double check your work.

## Phase VIIb: jQuery Triggering

There is one last step. Your `TweetCompose` also tries to insert
tweets into the feed. Should we copy over all the logic of
`InfiniteTweets` into `TweetCompose`? That doesn't sound very DRY.

Instead of having `TweetCompose` insert HTML into the DOM, have it
`jQuery#trigger` an `insert-tweet` event on your `#feed` ul. This is a
**custom event** (not a pre-defined browser event) that you can use so
that one module of code can signal another module. Here, this allows
`TweetCompose` to remain agnostic of how a new tweet is inserted; by
triggering the custom event, `TweetCompose` simply notifies
`InfiniteTweets` to do the work of insertion.

Add a listener for `insert-tweet` in the `InfiniteTweets` class and
have it fire an `InfiniteTweets#insertTweet` method. When you trigger
the event from the `TweetCompose` class, be sure to pass the newly
created tweet's data along as well.

**Common bug**: you may also want `insertTweet` to update the the
`lastCreatedAt` instance variable. If you were to compose a tweet and
not set `lastCreatedAt`, you'll fetch the same tweet again when you
make an AJAX call to `/feed`.

[underscore_rails]: https://github.com/rweng/underscore-rails
[underscore_erb]: https://github.com/appacademy/js-curriculum/blob/master/w6d5/underscore-templates.md#erb--underscore
