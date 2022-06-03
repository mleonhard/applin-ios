#  Maggie iOS Client
Copy this iOS app and customize it to connect to your
[`maggie-rs`](https://github.com/mleonhard/maggie-rs) server.

To use:
1. Clone this repo.
   - [Do not make a GitHub fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/what-happens-to-forks-when-a-repository-is-deleted-or-changes-visibility).
2. Add an icon
3. Add your server's URL to `Main.swift`
4. Edit `default.json`.  The app uses pages in that file until it connects to the server the first time.
   - Put your app's ID in the "Update" button action URL.
   - Optional: Add `/maggie-server-status` and `/maggie-contact-support-modal` pages.
     The default error modal has "Status" and "Contact Support" buttons which open those pages.
5. Use standard processes to build and test your app

## Development Progress

This project is not yet usable.  It is not production-ready.

- Pages
  - `nav-page`
    - [X] `title`
    - [X] `widget`
    - [X] custom back button actions
    - [ ] Use name of previous page, not "Back"
    - [ ] Swipe to go back with custom back button
  - `plain-page`
    - [X] `title`
    - [X] `widget`
  - `alert-modal`, `info-modal`, `question-modal`
    - [ ] `title`
    - [ ] `widgets`
  - `markdown-page`
    - [ ] `title`
    - [ ] `url`
    - [ ] `cache` boolean
- Widgets
  - [ ] Preserve widget data across page updates
  - [ ] Preserve widget data across app launches
    - <https://developer.apple.com/documentation/uikit/view_controllers/preserving_your_app_s_ui_across_launches>
  - `back-button`
    - [X] `actions`
    - [ ] Use name of previous page, not "Back"
  - `button`
    - [ ] `text`
    - [ ] `actions`, `actions-android`, `actions-ios`
    - [ ] `is-default`
    - [ ] `is-destructive`
  - `button-cell`
    - [ ] `text`
    - [ ] `actions`, `actions-android`, `actions-ios`
    - [ ] `is-destructive`
  - `checkbox`
    - [ ] `id`
    - [ ] `initial-value`
    - [ ] `actions`
  - `checkbox-cell`
    - [ ] `text`
    - [ ] `initial-value`
    - [ ] `actions`
  - `column`
    - [ ] `spacing`
    - [ ] `widgets`
    - [ ] `alignment`: `top`, `center`, `bottom`
  - `detail-cell`
    - [ ] `text`
    - [ ] `image-url`
    - [ ] `actions`
  - [X] `empty`
  - [ ] `error-cell`
  - [ ] `error-details`
  - [ ] `expand` with `min-height`, `min-width`, `max-height`, `max-width`, `widget`
  - [ ] `expand.alignment`: `top-start`, `top-center`, `top-end`, `center-start`, `center`, `center-end`, `bottom-start`, `bottom-center`, `bottom-end`
  - [ ] `date-picker`
  - [ ] `date-time-picker`
  - `horizontal-scroll`
    - [ ] `widget`
  - [ ] `icon` with `id`, `height`, `width`, `alignment`
  - `image`
    - [ ] `url`
    - [ ] dimensions
    - [ ] `disposition`: `cover`, `fit`, `stretch`
    - [ ] `image` zoom
    - [ ] retry load failure
  - [ ] `image-picker` camera
  - [ ] `image-picker` photo
  - [ ] `image-picker` upload
  - [ ] `image-picker` crop, resize, and rotate
  - [ ] `markdown`
  - [ ] `picker`
  - [ ] `radio-button`
  - [ ] `row` with `spacing`, `widgets`
  - [ ] `row.alignment`: `start`, `center`, `end`
  - [ ] `row` item sizing: unconstrained, fixed-width, max-width, min-width
  - [ ] `row` spacing: Make `Spacer` fixed size, and use `Wide` & `Tall` for expanded spacing.
  - [ ] `row` wrapping
  - `scroll`
    - [ ] `widget`
  - [ ] `spacer`
  - [ ] `table`
  - [ ] `tall` with `alignment`, `min-height`, `max-height`, `widget`
  - `text`
    - [X] `text`
    - [ ] `text` should not show markdown-formatting
  - [ ] `text-cell`
  - [ ] `time-picker`
  - [ ] `wide` with `alignment`, `min-width`, `max-width`, `widget`
- Actions:
  - `copy-to-clipboard`
    - [X] implement
    - [ ] show confirmation popover
  - `hilight:WIDGET_ID`
    - [ ] show flashing highlight
    - [ ] scroll the widget into view
  - [ ] `launch-url:URL`
  - [ ] `logout`
    - <https://developer.apple.com/documentation/foundation/urlsession/1411479-reset>
  - [X] `pop`
  - [X] `push:PAGE_KEY`
  - `rpc:/PATH`
    - [X] call server
    - [X] send cookies, receive & save cookies
    - [ ] send page stack to server
    - [ ] send page variables to server, `rpc:/PATH,ARG1,ARG2`
    - [ ] Ephemeral client data, to allow an RPC to include data from multiple pages
    - [ ] Option to automatically perform RPC when data changes, after a delay
    - [ ] Prevent overlapping RPCs or actions
    - [ ] Show modal to prevent race between user changing widgets and server changing UI in RPC response
    - [X] response can update pages
    - [ ] response can update stack
    - [ ] show user error dialog
    - [ ] show client error dialog
    - [ ] show server error dialog
- Style
  - Pick one:
    - Each widget gets values from the style subsystem
    - Each widget has normal attributes for style.
      - Styles are a kind of JSON overlay which replace attributes.  This is like class inheritance.
      - Implement styles entirely on the server.
        This could make tests more verbose.
        This would simplify debugging. <--- This one.
  - [ ] `default-style` key
  - [ ] `style` attribute on pages and widgets
  - [ ] `style` widget
  - Text:
    - [ ] size
    - [ ] font
    - [ ] weight
    - [ ] color
    - [ ] effects
    - [ ] auto-size, with min & max
    - [ ] auto-size group
  - Box
    - [ ] width, height, min & max & preferred
    - [ ] padding
    - [ ] margin
    - Border
      - [ ] color
      - [ ] width
      - [ ] corner radius
      - [ ] pattern
    - Shadow
    - Background
      - [ ] color
      - [ ] pattern
      - [ ] gradient
    - Background image
      - [ ] disposition
      - [ ] origin
      - [ ] opacity
      - [ ] effects
  - Navigation bar
    - [ ] title text style
    - [ ] button text style
  - Markdown
  - Other widget-specific settings
- Connect to server
  - [X] Receive page updates
  - [ ] Receive page stack updates
  - [ ] Receive actions to execute immediately
  - [ ] Always apply diffs from connection and RPCs in correct order.
  - [ ] Avoid downloading all pages on new connection, use cached data
  - [X] Connect only when app is active.  Disconnect when in background, after a delay.
  - [ ] Let pages specify "don't connect", "connect automatically" or "poll this RPC on this interval".
- Save data
  - [X] pages
  - [X] Write pages after 10s delay, to reduce power usage
  - [X] stack
  - [ ] downloaded images
  - [X] cookies
- Notifications
  - [ ] action to request notifications
  - [ ] subscribe to notifications
  - [ ] Tap a notification to open the target page
  - [ ] Display received notifications while using app
- Logging
  - [ ] gzip
  - [ ] log crashes
  - [ ] log JSON
  - [ ] encrypt with public key
  - [ ] max file size bytes
  - [ ] max file interval seconds
  - [ ] upload url
- Test coverage
  - [ ] 1%
  - [ ] 50%
  - [ ] 80%
  - [ ] 95%
- Integration tests
  - [ ] cookie & logout
  - [ ] 
- [X] Load `default.json` on startup
- Respond to memory pressure warnings
  <https://developer.apple.com/documentation/uikit/app_and_environment/managing_your_app_s_life_cycle/responding_to_memory_warnings>
  - Release non-visible images
  - Write cache since app may get terminated
- [ ] Download media in background task
  - <https://www.avanderlee.com/swift/urlsession-common-pitfalls-with-background-download-upload-tasks/>
- [ ] Reduce memory usage of pages that are not visible.
