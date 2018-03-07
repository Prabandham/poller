defmodule PollerWeb.PollChannel do
  use PollerWeb, :channel

  def join("poll:home", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # New polls will be handled here.
  def handle_in("new_poll", payload, socket) do
    {:noreply, socket}
  end

  # User Votes will be handled here.
  def handle_in("vote", payload, socket) do
    IO.inspect(payload)
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (poll:lobby).
  def handle_in("shout", payload, socket) do
    # BroadCast will send the message to every one. While push will send it just to the person who initiated the call.
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
