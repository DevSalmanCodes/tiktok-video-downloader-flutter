// To parse this JSON data, do
//
//     final tikTokData = tikTokDataFromJson(jsonString);

import 'dart:convert';

TikTokData tikTokDataFromJson(String str) => TikTokData.fromJson(json.decode(str));

String tikTokDataToJson(TikTokData data) => json.encode(data.toJson());

class TikTokData {
    int code;
    String msg;
    double processedTime;
    Data data;

    TikTokData({
        required this.code,
        required this.msg,
        required this.processedTime,
        required this.data,
    });

    factory TikTokData.fromJson(Map<String, dynamic> json) => TikTokData(
        code: json["code"],
        msg: json["msg"],
        processedTime: json["processed_time"]?.toDouble(),
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "processed_time": processedTime,
        "data": data.toJson(),
    };
}

class Data {
    String id;
    String region;
    String title;
    String cover;
    String originCover;
    int duration;
    String play;
    String wmplay;
    int size;
    int wmSize;
    String music;
    MusicInfo musicInfo;
    int playCount;
    int diggCount;
    int commentCount;
    int shareCount;
    int downloadCount;
    int collectCount;
    int createTime;
    dynamic anchors;
    String anchorsExtras;
    bool isAd;
    CommerceInfo commerceInfo;
    String commercialVideoInfo;
    Author author;

    Data({
        required this.id,
        required this.region,
        required this.title,
        required this.cover,
        required this.originCover,
        required this.duration,
        required this.play,
        required this.wmplay,
        required this.size,
        required this.wmSize,
        required this.music,
        required this.musicInfo,
        required this.playCount,
        required this.diggCount,
        required this.commentCount,
        required this.shareCount,
        required this.downloadCount,
        required this.collectCount,
        required this.createTime,
        required this.anchors,
        required this.anchorsExtras,
        required this.isAd,
        required this.commerceInfo,
        required this.commercialVideoInfo,
        required this.author,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        region: json["region"],
        title: json["title"],
        cover: json["cover"],
        originCover: json["origin_cover"],
        duration: json["duration"],
        play: json["play"],
        wmplay: json["wmplay"],
        size: json["size"],
        wmSize: json["wm_size"],
        music: json["music"],
        musicInfo: MusicInfo.fromJson(json["music_info"]),
        playCount: json["play_count"],
        diggCount: json["digg_count"],
        commentCount: json["comment_count"],
        shareCount: json["share_count"],
        downloadCount: json["download_count"],
        collectCount: json["collect_count"],
        createTime: json["create_time"],
        anchors: json["anchors"],
        anchorsExtras: json["anchors_extras"],
        isAd: json["is_ad"],
        commerceInfo: CommerceInfo.fromJson(json["commerce_info"]),
        commercialVideoInfo: json["commercial_video_info"],
        author: Author.fromJson(json["author"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "region": region,
        "title": title,
        "cover": cover,
        "origin_cover": originCover,
        "duration": duration,
        "play": play,
        "wmplay": wmplay,
        "size": size,
        "wm_size": wmSize,
        "music": music,
        "music_info": musicInfo.toJson(),
        "play_count": playCount,
        "digg_count": diggCount,
        "comment_count": commentCount,
        "share_count": shareCount,
        "download_count": downloadCount,
        "collect_count": collectCount,
        "create_time": createTime,
        "anchors": anchors,
        "anchors_extras": anchorsExtras,
        "is_ad": isAd,
        "commerce_info": commerceInfo.toJson(),
        "commercial_video_info": commercialVideoInfo,
        "author": author.toJson(),
    };
}

class Author {
    String id;
    String uniqueId;
    String nickname;
    String avatar;

    Author({
        required this.id,
        required this.uniqueId,
        required this.nickname,
        required this.avatar,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        uniqueId: json["unique_id"],
        nickname: json["nickname"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": uniqueId,
        "nickname": nickname,
        "avatar": avatar,
    };
}

class CommerceInfo {
    bool advPromotable;
    bool auctionAdInvited;
    int brandedContentType;
    bool withCommentFilterWords;

    CommerceInfo({
        required this.advPromotable,
        required this.auctionAdInvited,
        required this.brandedContentType,
        required this.withCommentFilterWords,
    });

    factory CommerceInfo.fromJson(Map<String, dynamic> json) => CommerceInfo(
        advPromotable: json["adv_promotable"],
        auctionAdInvited: json["auction_ad_invited"],
        brandedContentType: json["branded_content_type"],
        withCommentFilterWords: json["with_comment_filter_words"],
    );

    Map<String, dynamic> toJson() => {
        "adv_promotable": advPromotable,
        "auction_ad_invited": auctionAdInvited,
        "branded_content_type": brandedContentType,
        "with_comment_filter_words": withCommentFilterWords,
    };
}

class MusicInfo {
    String id;
    String title;
    String play;
    String cover;
    String author;
    bool original;
    int duration;
    String album;

    MusicInfo({
        required this.id,
        required this.title,
        required this.play,
        required this.cover,
        required this.author,
        required this.original,
        required this.duration,
        required this.album,
    });

    factory MusicInfo.fromJson(Map<String, dynamic> json) => MusicInfo(
        id: json["id"],
        title: json["title"],
        play: json["play"],
        cover: json["cover"],
        author: json["author"],
        original: json["original"],
        duration: json["duration"],
        album: json["album"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "play": play,
        "cover": cover,
        "author": author,
        "original": original,
        "duration": duration,
        "album": album,
    };
}
