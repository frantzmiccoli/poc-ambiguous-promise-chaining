Q = require 'q'

console.log "EXPECTED"
console.log "defining lagged call 1"
console.log "resolving lagged call 1"
console.log "callback 1: 1"
console.log "defining lagged call 2"
console.log "resolving lagged call 2"
console.log "callback 2: 2"
console.log "callback 3: undefined"
console.log "defining lagged call 3"
console.log "resolving lagged call 3"
console.log "callback 4: 3"
console.log ""
console.log "ACTUAL"

laggedFunction = (idNumber) ->
  deferred = Q.defer()
  console.log('defining lagged call ' + idNumber)
  setTimeout(() ->
    console.log('resolving lagged call ' + idNumber)
    deferred.resolve(idNumber)
  , 90)
  deferred.promise

promise = laggedFunction(1)
promise.then((idNumber) ->
  console.log 'callback 1: ' + idNumber
  laggedFunction(2)
)
.then((idNumber) -> console.log 'callback 2: ' + idNumber)
.then((idNumber) ->
    console.log 'callback 3: ' + idNumber
    laggedFunction(3)
)
.then((idNumber) -> console.log 'callback 4: ' + idNumber)

