#coding: utf-8
#mock paperclip相关功能
#参考 http://awesomeprogrammer.com/blog/2012/08/24/stubbing-paperclip-file-upload-with-rspec/
module PaperclipMacros
  def stub_paperclip(model)
    before do
      model.any_instance.stub(:save_attached_files).and_return(true)
      model.any_instance.stub(:delete_attached_files).and_return(true)
      Paperclip::Attachment.any_instance.stub(:post_process).and_return(true)
    end
  end
end
