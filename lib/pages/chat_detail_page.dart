import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shooe/models/message_model.dart';
import 'package:shooe/models/product_model.dart';
import 'package:shooe/providers/auth_provider.dart';
import 'package:shooe/services/message_service.dart';
import 'package:shooe/theme.dart';
import 'package:shooe/widgets/chat_bubble.dart';

class ChatDetailPage extends StatefulWidget {

  ProductModel product;
  ChatDetailPage(this.product);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  @override
  Widget build(BuildContext context) {

    TextEditingController messageController = TextEditingController(text: '');

    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleAddMessage() async {
      await MessageService().addMessage(authProvider.user, true, messageController.text, widget.product);
      setState(() {
        widget.product = UninitializedProductModel();
        messageController.text = '';
      });
    }

    Widget header() {
      return PreferredSize(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: AppBar(
            backgroundColor: backgroundColor1,
            centerTitle: false,
            title: Row(
              children: [
                Image.asset(
                  'assets/image_online_shop_logo.png',
                  width: 50,
                ),
                SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shoe Store',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 14
                      ),
                    ),
                    Text(
                      'Online',
                      style: secondaryTextStyle.copyWith(
                        fontWeight: light,
                        fontSize: 14
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(82),
      );
    }

    Widget productPreview() {
      return Container(
        padding: EdgeInsets.all(10),
        width: 225,
        height: 72,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: backgroundColor5,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primaryColor
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.product.galleries[0].url,
                width: 54,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.product.name,
                    style: primaryTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2,),
                  Text(
                    '\$${widget.product.price}',
                    style: priceTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.product = UninitializedProductModel();
                });
              },
              child: Image.asset(
                'assets/btn_remove.png',
                width: 22,
              ),
            ),
          ],
        ),
      );
    }

    Widget chatInput() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.product is UninitializedProductModel
                ? SizedBox()
                : productPreview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor4,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: TextFormField(
                      style: primaryTextStyle,
                      controller: messageController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type message...',
                        hintStyle: subtitleTextStyle
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: handleAddMessage,
                  child: Image.asset(
                    'assets/btn_send.png',
                    width: 45,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return StreamBuilder<List<MessageModel>>(
        stream: MessageService().getMessagesByUserId(userId: authProvider.user.id),
        builder: (context, snapshot) {

          if(snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              children: snapshot.data.map((MessageModel message) => ChatBubble(isSender: message.isFromUser, text: message.message, product: message.product,)).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        }
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor3,
      appBar: header(),
      bottomNavigationBar: chatInput(),
      body: content(),
    );
  }
}
