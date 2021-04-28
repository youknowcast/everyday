# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EverydayApp.Repo.insert!(%EverydayApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias EverydayApp.Repo
alias EverydayApp.User
alias EverydayApp.Calendar
alias EverydayApp.Training
