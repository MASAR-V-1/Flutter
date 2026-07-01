import 'package:flutter/material.dart';

import 'package:masar_app/core/theme/app_colors.dart';
import 'package:masar_app/core/theme/app_spacing.dart';

class AiAgentScreen extends StatefulWidget {
  const AiAgentScreen({super.key});

  static const String routePath = '/ai-agent';
  static const String routeName = 'ai-agent';

  @override
  State<AiAgentScreen> createState() => _AiAgentScreenState();
}

class _AiAgentScreenState extends State<AiAgentScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<_AiMessage> _messages = const [
    _AiMessage(
      text:
          'مرحباً، أنا مساعد مسار الذكي. أستطيع مساعدتك في فهم المهام، التقارير، العمليات، والإجراءات داخل النظام.',
      isUser: false,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _showComingSoonMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('سيتم ربط المساعد الذكي لاحقاً: $text')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(82),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
                colors: [AppColors.primaryBlue, AppColors.operationalGreen],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: 72,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'مساعد مسار الذكي',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AiIntroCard(onSuggestionTap: _showComingSoonMessage),
                    const SizedBox(height: AppSpacing.m),
                    ..._messages.map((message) {
                      return _AiMessageBubble(message: message);
                    }),
                  ],
                ),
              ),
            ),
            _AiInputBar(
              controller: _messageController,
              onSend: () {
                final text = _messageController.text.trim();

                if (text.isEmpty) return;

                _messageController.clear();
                _showComingSoonMessage(text);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AiIntroCard extends StatelessWidget {
  final ValueChanged<String> onSuggestionTap;

  const _AiIntroCard({required this.onSuggestionTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.primaryBlue,
              size: 30,
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            'كيف أقدر أساعدك اليوم؟',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'يمكنك سؤال المساعد عن المهام، التقارير، العمليات، أو طريقة تنفيذ إجراء داخل مسار.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textVariant,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              _SuggestionChip(
                text: 'ما المهام التي تحتاج متابعة؟',
                onTap: onSuggestionTap,
              ),
              _SuggestionChip(
                text: 'اشرح لي حالة التقارير',
                onTap: onSuggestionTap,
              ),
              _SuggestionChip(
                text: 'ما العمليات المتأخرة؟',
                onTap: onSuggestionTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String text;
  final ValueChanged<String> onTap;

  const _SuggestionChip({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(text),
      onPressed: () => onTap(text),
      backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.06),
      labelStyle: const TextStyle(
        color: AppColors.primaryBlue,
        fontWeight: FontWeight.w700,
      ),
      side: BorderSide(color: AppColors.primaryBlue.withValues(alpha: 0.14)),
    );
  }
}

class _AiMessageBubble extends StatelessWidget {
  final _AiMessage message;

  const _AiMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.s),
        padding: const EdgeInsets.all(AppSpacing.s),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: message.isUser
                ? AppColors.primaryBlue
                : AppColors.outlineVariant,
          ),
        ),
        child: Text(
          message.text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: message.isUser ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _AiInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _AiInputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.m,
          AppSpacing.s,
          AppSpacing.m,
          AppSpacing.s,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.outlineVariant)),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 3,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintText: 'اكتب سؤالك هنا...',
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.m,
                    vertical: AppSpacing.s,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.s),
            FloatingActionButton.small(
              heroTag: 'masar-ai-send-button',
              onPressed: onSend,
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              child: const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiMessage {
  final String text;
  final bool isUser;

  const _AiMessage({required this.text, required this.isUser});
}
