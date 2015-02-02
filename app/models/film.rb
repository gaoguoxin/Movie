require 'spreadsheet'
Spreadsheet.client_encoding = 'UTF-8'
class Film
  include Mongoid::Document
  field :title, type: String
  field :director,type:String
  field :area,type:String
  field :actors,type:String
  field :types,type:String
  field :descript,type:String
  field :basic_info,type:Hash,default:{tudou:{0 =>[],1 => {}},tecent:{0 => [],1 => {}},youku:{0 => [],1 =>{}},iqiyi:{0 => [],1 => {}},hunantv:{0 => [],1 => {}}}
  field :index_info,type:Hash,default:{tudou:{0 =>[],1 => {}},tecent:{0 => [],1 => {}},youku:{0 => [],1 =>{}},iqiyi:{0 => [],1 => {}},hunantv:{0 => [],1 => {}}}
  field :status, type: Integer


  def self.export
  	Film.each do |film|
  		puts film.title
  		puts film.area
        puts film.types
  		puts film.director
  		puts film.actors

  	end
  end



  def self.export_to_excel
    book   = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet, :name => '电影数据' 
    sheet1.row(0).concat %w(电影名称  地区  类型  导演  主演  简介  视频网站   视频类型   视频地址    播放数   评论数   点赞数   点踩数)
    row_count = 0
    Film.each do |film|
    	film.basic_info.each_pair do |site,data|
    		pre_data  = film.basic_info["#{site}"]['0']
    		play_data = film.basic_info["#{site}"]['1']
    		d = ["#{film.title}","#{film.area}","#{film.types}","#{film.director}","#{film.actors}","#{film.descript}","#{site}"]
    		if play_data.present?  # 正片数据
			  rw = d + ['正片',"#{play_data['url']}","#{play_data['play_count']}","#{play_data['comment_count']}","#{play_data['up_count']}","#{play_data['down_count']}"]
    		  sheet1.row(row_count + 1).replace(rw)
    		  row_count += 1
    		end

    		if pre_data.present? # 预告片数据
    			pre_data.each do |hash_data|
    				rp =  d + ["预告片","#{hash_data['url']}","#{hash_data['play_count']}","#{hash_data['comment_count']}","#{hash_data['up_count']}","#{hash_data['down_count']}"]
    				sheet1.row(row_count + 1).replace(rp)
    				row_count += 1
    			end
    		end
    	end
    end
    book.write   "#{Rails.root.to_s}/public/export/data.xls"
  end

end


	# {
	# 	tudou:{
	# 		0:[
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			},
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			},
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			},
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			}												
	# 		],
	# 		1:{
	# 			url:'xxxxxx',#网址
	# 			up_count:100, #点赞数
	# 			down_count:100,#点踩数
	# 			comment_count:100,#评论数
	# 			play_count:100 #播放次数
	# 		}
	# 	},
	# 	tecent:{
	# 		0:[
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			},
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			},
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			},
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			}												
	# 		],
	# 		1:{
	# 			url:'xxxxxx',#网址
	# 			up_count:100, #点赞数
	# 			down_count:100,#点踩数
	# 			comment_count:100,#评论数
	# 			play_count:100 #播放次数
	# 		}
	# 	},
	# 	youku:{
	# 		0:[
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			},
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			},
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			},
	# 			{
	# 				url:'xxxxxx',#网址
	# 				up_count:100, #点赞数
	# 				down_count:100,#点踩数
	# 				comment_count:100,#评论数
	# 				play_count:100 #播放次数
	# 			}												
	# 		],
	# 		1:{
	# 			url:'xxxxxx',#网址
	# 			up_count:100, #点赞数
	# 			down_count:100,#点踩数
	# 			comment_count:100,#评论数
	# 			play_count:100 #播放次数
	# 		}
	# 	}
	# }
