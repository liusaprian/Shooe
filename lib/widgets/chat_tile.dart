import 'package:flutter/material.dart';
import 'package:shooe/models/message_model.dart';
import 'package:shooe/models/product_model.dart';
import 'package:shooe/pages/chat_detail_page.dart';
import 'package:shooe/theme.dart';

class ChatTile extends StatelessWidget {

  final MessageModel message;
  ChatTile({this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailPage(UninitializedProductModel())));
      },
      child: Container(
        margin: EdgeInsets.only(top: 32),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/image_shop_logo.png',
                  width: 54,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shoe Store',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        message.message,
                        style: secondaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: light,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Now',
                  style: secondaryTextStyle.copyWith(fontSize: 10),
                ),
              ],
            ),
            SizedBox(height: 12,),
            Divider(
              thickness: 1,
              color: Color(0xff3E3E58),
            )
          ],
        ),
      ),
    );
  }
}
