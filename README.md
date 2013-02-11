Exposed
=======

A Rails engine that exposes ActiveRecord models as a JSON API with minimum hassle.

## Installation ##

    gem install exposed

## Usage ##

Suppose you have some ActiveRecord models:

    class Post < ActiveRecord::Base
        attr_accessible :content, :title
        has_many :comments
    end

    class Comment < ActiveRecord::Base
        attr_accessible :post, :content
        belongs_to :post
    end

To expose them as JSON API, you need to do two things:

**1. Create controllers** in /controllers:

    class PostsController < Exposed::Base
    end

    class CommentsController < Exposed::Base
    end

**2. Add routes to /config/routes.rb:**

    resources :posts
    resources :comments

### GET ###

The collections will be available at:

**`GET /posts`**
**`GET /comments`**

They will return JSON, of course. For example, **`/posts`** will return:

    [
        {
            "id"       : 1,
            "title"    : "First post",
            "content"  : "First post content"
        },

        {
            "id"       : 2,
            "title"    : "Second post",
            "content"  : "Second post content"
        }
    ]

By default, each model's JSON representation will include all attributes. If you want to include associations, you can use **`include`** URL parameter:

**`GET /posts?include=comments`**

This will return:

    [
        {
            "id"       : 1,
            "title"    : "First post",
            "content"  : "First post content"
            "comments" : [
                { "id": 1, "post_id": 1, "content": "You are right." },
                { "id": 2, "post_id": 1, "content": "You are wrong." }
            ]
        },

        {
            "id"       : 2,
            "title"    : "Second post",
            "content"  : "Second post content"
            "comments" : []
        }
    ]

If you want to exclude some attributes, you can use the **`exclude`** URL parameter:

**`GET /posts?exclude=id,content`**

This will return:

    [
        { "title"    : "First post" },
        { "title"    : "Second post" }
    ]

Individual models are available at:

**`GET /posts/1`**

This will return:

    {
        "id"       : 1,
        "title"    : "First post",
        "content"  : "First post content"
    }

And you can use **`include`** and **`exclude`** URL parameters just like with collections.

### POST ###

New models can be created by posting JSON to:

**`POST /posts { "title": "Third post", "content": "Third post content" }`**

The JSON representation of the newly created model is returned.

### PUT ###

Models can be modified by putting JSON to:

**`PUT /posts/1 { "title": "Modified post", "content": "Modified post content" }`**

The new JSON representation of the modified model is returned. The ommited attributes remain unchanged, so PUT actually behaves like PATCH (sorry, REST).

### DELETE ###

Models can be deleted by sending a DELETE request to:

**`DELETE /posts/1`**

The JSON representation of the deleted model is returned.

## License ##

MIT.
