![Swift 5.10](https://img.shields.io/badge/swift-5.10-orange.svg)
![Vapor v4.0](https://img.shields.io/badge/vapor-4.0-blue) [![CircleCI](https://circleci.com/gh/maartene/BattlesnakeSwiftStarter.svg?style=shield)](https://circleci.com/gh/maartene/BattlesnakeSwiftStarter) [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# Battlesnake Swift Starter Project

An unofficial Battlesnake template written in Swift. Get started at [play.battlesnake.com](https://play.battlesnake.com). This is a port of the official JavaScript starter.

![Battlesnake Logo](https://media.battlesnake.com/social/StarterSnakeGitHubRepos_JavaScript.png)

This project is a great starting point for anyone wanting to program their first Battlesnake in Swift. It can be run locally or easily deployed to a cloud provider of your choosing. See the [Battlesnake API Docs](https://docs.battlesnake.com/api) for more detail.

## Technologies Used

This project uses [Vapor](https://vapor.codes/). It also comes with an optional [Dockerfile](https://docs.docker.com/engine/reference/builder/) to help with deployment.

## Run tests

`# swift test`

## Start Your Battlesnake server

`# swift run`

You should see the following output once it is running:

```sh
Running Battlesnake at http://0.0.0.0:8000
```

Open [localhost:8000](http://localhost:8000) in your browser and you should see

```json
{
  "apiversion": "1",
  "author": "",
  "color": "#888888",
  "head": "default",
  "tail": "default"
}
```

## Play a Game Locally

Install the [Battlesnake CLI](https://github.com/BattlesnakeOfficial/rules/tree/main/cli)

- You can [download compiled binaries here](https://github.com/BattlesnakeOfficial/rules/releases)
- or [install as a go package](https://github.com/BattlesnakeOfficial/rules/tree/main/cli#installation) (requires Go 1.18 or higher)

Command to run a local game

```sh
battlesnake play -W 11 -H 11 --name 'Swift Starter Project' --url http://localhost:8000 -g solo --browser
```

## Configuring the server

- Hostname and port number are set in `configure.swift`.
- Configure your colors and name in the `static var `default`: BattlesnakeInfo` in `Battlesnake.swift`.

## Next Steps

Continue with the [Battlesnake Quickstart Guide](https://docs.battlesnake.com/quickstart) to customize and improve your Battlesnake's behavior. You can find pointers to do so in `MovementTests.swift` (i.e. adopt TDD to get a smarter snake.). Implement the behaviour itself in `Movement.swift`

**Note:** To play games on [play.battlesnake.com](https://play.battlesnake.com) you'll need to deploy your Battlesnake to a live web server OR use a port forwarding tool like [ngrok](https://ngrok.com/) to access your server locally.

## Work-in-progress

- Only the bare minimum of the JavaScript starter is implemented. Next steps will be to decode the entire gamestate for move requests. Now only your own snake is decoded.
