#!/bin/sh

spire-agent api fetch jwt -audience sigstore -socketPath /run/spire/sockets/spire-agent.sock | sed '2q;d' | xargs
