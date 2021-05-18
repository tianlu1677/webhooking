import consumer from "./consumer"

const  loadItem = async  (webhook_id, backpack_id) => {
  const res = await fetch(`/webhooks/${webhook_id}/left_list_item?backpack_id=${backpack_id}`, {
    method: 'post',
  })
  const js = await res.text()
  console.log(js)
  eval(js)
}

const channel = consumer.subscriptions.create("WebhookNotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('connected this channel')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("channel send a message", data)
    // Called when there's incoming data on the websocket for this channel
    const {webhook_id, backpack_id} = data
    loadItem(webhook_id, backpack_id)
  }
});