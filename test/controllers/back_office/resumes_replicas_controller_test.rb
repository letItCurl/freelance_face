# frozen_string_literal: true

require 'test_helper'
# copy for resume controller
module BackOffice
  class ResumesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @resume = back_office_resumes(:one)
    end

    test 'should get index' do
      get back_office_resumes_url
      assert_response :success
    end

    test 'should get new' do
      get new_back_office_resume_url
      assert_response :success
    end

    test 'should create back_office_resume' do
      assert_difference('BackOffice::Resume.count') do
        post back_office_resumes_url, params: { back_office_resume: {} }
      end

      assert_redirected_to back_office_resume_url(BackOffice::Resume.last)
    end

    test 'should show back_office_resume' do
      get back_office_resume_url(@resume)
      assert_response :success
    end

    test 'should get edit' do
      get edit_back_office_resume_url(@resume)
      assert_response :success
    end

    test 'should update back_office_resume' do
      patch back_office_resume_url(@resume), params: { back_office_resume: {} }
      assert_redirected_to back_office_resume_url(@resume)
    end

    test 'should destroy back_office_resume' do
      assert_difference('BackOffice::Resume.count', -1) do
        delete back_office_resume_url(@resume)
      end

      assert_redirected_to back_office_resumes_url
    end
  end
end
