# Learning Elm + Parcel

Developing the [front-end test](https://gist.github.com/giulianovarriale/269f948dbf18573190ae59410be849b4) in [Elm](https://elm-lang.org) and using [Parcel](https://parceljs.org)

## Requirements

- Node 8.9+

## Development

To run the project in development mode execute the following commands:

1. `yarn install`
2. `yarn run start`


Now open the http://localhost:1234 url on your browser.

## Test

I use [`elm-test`](https://github.com/rtfeldman/node-test-runner/tree/0.19) 
to run tests on Elm. 
You can run tests with the following commands:

```
yarn test # run the whole suite
yarn test tests/Foo.elm # run a single file
yarn test --watch # enable the watch mode
```

## Production

Before generating the production bundle remove the **dist** folder.

1. `yarn install`
2. `rm -rf dist`
3. `yarn build`

The production ready files will be founded under the dist directory.
