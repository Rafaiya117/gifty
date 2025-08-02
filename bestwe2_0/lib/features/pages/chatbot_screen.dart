import 'package:bestwe2_0/app_State/chat_state.dart';
import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});
  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<ChatMessage> _messages = [];
  final List<Map<String, dynamic>> _suggestedProducts = [];
  final TextEditingController _controller = TextEditingController();
  final List<String> relationshipSuggestions = ['Best Friend', 'Dad', 'Boyfriend', 'Mom'];
  // String? _sessionId;
  final ChatService _chatService = ChatService();

  void _onSuggestionTap(String suggestion) {
    setState(() {
      _controller.text = suggestion;  // Update the input field with the suggestion added by Rafaiya
    });
  }

  // Function to handle when a suggestion is tapped, modified by rafaiya
  Future<void> handleMessageSend(String text) async {
    final userMessage = text.trim();
    if (userMessage.isEmpty) return;
    _controller.clear();
    setState(() {
      _messages.add(ChatMessage(text: userMessage, isUser: true));
      _suggestedProducts.clear();
    });
    if (_chatService.sessionId == null) {
      await _chatService.sendUserMessage(context: context, text: userMessage,
        onBotMessage: (msg) => setState(() => _messages.add(msg)),
      );
    } else {
      await _chatService.sendFollowUpMessage(
        context: context,
        message: userMessage,
        onRawMessage: (msg) => setState(() => _messages.add(ChatMessage(text: msg, isUser: false))),
        onProducts: (products) => setState(() => _suggestedProducts.addAll(products)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chat AI',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF5B4025),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications,
                            color: const Color(0xFF5B4025)),
                        onPressed: () => Navigator.pushNamed(context, '/notifications'),
                      ),
                      const SizedBox(width: 16),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: const Color(0xFF5B4025)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                reverse: false,
                child: Column(
                  children: [
                    // Display the introductory message with "I am Lux\nBestower of Light"
                    if (_messages.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDABEB6),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  // Replace with your own logo widget or image
                                  Image.asset(AppAssets.logo, width: 64.w, height: 64.w),
                                  const SizedBox(height: 12),
                                  Text(
                                    'I am Lux\nBestower of Light',
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF5B4025),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'I am Here to inspire\nthoughtful giving, beyond\nthe expected',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: const Color(0xFF5B4025),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Suggestions section displayed below the "I am Lux" container
                          ],
                        ),
                      ),

                    // Display chat messages if available
                    if (_messages.isNotEmpty)
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _messages.length,
                        itemBuilder: (context, idx) {
                          final msg = _messages[idx];
                          return ChatBubble(text: msg.text, isUser: msg.isUser);
                        },
                      ),

                    // Show product suggestions if any
                    if (_suggestedProducts.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Suggestions for you:",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF5B4025),
                              ),
                            ),
                            ..._suggestedProducts
                                .map((item) => ProductCard(item: item))
                                .toList(),
                          ],
                        ),
                      ),

                    // Relationship suggestions horizontal list (optional)
                    if (_messages.isNotEmpty)
                      SizedBox(
                        height: 48,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          children: relationshipSuggestions.map(
                                (label) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: const Color(0xFFEAEAEA)),
                              ),
                              child: Text(
                                label,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: const Color(0xFF5B4025),
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _SuggestionsSection(onSuggestionTap: _onSuggestionTap,),
            // Input area
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFEAEAEA)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: _messages.isEmpty
                                ? 'Ask Lux'
                                : 'Choose or type your relationship',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: const Color(0xFF5B4025)),
                          onSubmitted: handleMessageSend,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => handleMessageSend(_controller.text),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFF5B4025),
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  class _SuggestionsSection extends StatelessWidget {
  // const _SuggestionsSection();
  final Function(String) onSuggestionTap; // This will be the callback function

  const _SuggestionsSection({Key? key, required this.onSuggestionTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '✨ I suggest you some names you can ask me..',
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                color: const Color(0xFF5B4025),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 44.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 0),
              children: [
                for (final label in ['Father\'s Day', 'Mother\'s Day', 'Valentine\'s Day'])
                  GestureDetector(
                    onTap:()=>onSuggestionTap(label),
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(color: const Color(0xFFEAEAEA)),
                      ),
                      child: Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          color: const Color(0xFF5B4025),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'You have 2 free massage left. ',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => Dialog(
                      backgroundColor: const Color(0xFFF5ECE5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Free limit\nReached',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dancingScript(
                                fontSize: 38,
                                color: const Color(0xFF5B4025),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 48),
                            SizedBox(
                              width: 320,
                              height: 64,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5B4025),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  elevation: 8,
                                  shadowColor: const Color(0x22000000),
                                ),
                                onPressed: () => context.push('/subscription-plan'),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.flash_on, color: Colors.greenAccent, size: 32),
                                    const SizedBox(width: 16),
                                    Text(
                                      'Update Now',
                                      style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Text(
                  'Get Premium',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: Colors.amber[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  const ChatBubble({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF5B4025) : Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: isUser ? Colors.white : const Color(0xFF5B4025),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Image.network(
          item['image'] ?? '',
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: Text(
          item['name'] ?? '',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          item['description'] ?? '',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        trailing: Text(
          '৳${item['price']}',
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        onTap: () {
          final url = item['url'];
          if (url != null && url.toString().isNotEmpty) {
            launchUrl(Uri.parse(url));
          }
        },
      ),
    );
  }
}

