class Film
  include Mongoid::Document
  field :title, type: String
  field :task_url, type: String
  field :director,type:String
  field :area,type:String
  field :actors,type:String
  field :types,type:String
  field :descript,type:String
  field :basic_info,type:Hash,default:{tudou:{0 =>[],1 => {}},tecent:{0 => [],1 => {}},youku:{0 => [],1 =>{}},iqiyi:{0 => [],1 => {}},hunantv:{0 => [],1 => {}}}
  field :index_info,type:Hash,default:{tudou:{0 =>[],1 => {}},tecent:{0 => [],1 => {}},youku:{0 => [],1 =>{}},iqiyi:{0 => [],1 => {}},hunantv:{0 => [],1 => {}}}
  field :status, type: Integer
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
