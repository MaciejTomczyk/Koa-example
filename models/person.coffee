mongoose = require 'mongoose'

Person = new mongoose.Schema(
  name: { type: String, trim: true }
  lastname: { type: String, trim: true }
  created_at: { type: Date, default: Date.now }
)

mongoose.model "Person", Person