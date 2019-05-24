#!/bin/bash -e
source "$(dirname "$0")"/../pattern-ci/scripts/resources.sh
main(){
    if ! docker-compose up -d; then
        test_failed "$0"
    fi
    if ! docker-compose ps; then
        test_failed "$0"
    fi
    if ! curl localhost:5000/api/v1/data -X PUT -H "Content-Type: application/json" -d '{"total": 100}'; then
        test_failed "$0"
    fi
    if ! curl localhost:5000/api/v1/chat -X POST -H "Content-Type: application/json" -d '{"message": "Game of Thrones", "travis": true}'; then
        test_failed "$0"
    fi
    test_passed "$0"
}
main "$@" 
