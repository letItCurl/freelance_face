# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_127_000_023) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'resumes', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.text 'about'
    t.string 'type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.uuid 'user_id'
    t.jsonb 'settings'
    t.text 'job_description'
    t.jsonb 'recruter'
    t.string 'slug'
    t.string 'title'
    t.index ['user_id'], name: 'index_resumes_on_user_id'
  end

  create_table 'resumes_experiences', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.text 'skills'
    t.datetime 'started_at'
    t.datetime 'ended_at'
    t.uuid 'resume_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['resume_id'], name: 'index_resumes_experiences_on_resume_id'
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.boolean 'admin', default: false, null: false
    t.string 'username', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.jsonb 'settings'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['username'], name: 'index_users_on_username', unique: true
  end

  add_foreign_key 'resumes', 'users', on_delete: :cascade
  add_foreign_key 'resumes_experiences', 'resumes', on_delete: :cascade
end
