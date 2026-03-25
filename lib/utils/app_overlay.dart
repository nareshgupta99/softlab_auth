import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
//  OVERLAY HELPER  —  AppOverlay
//
//  Usage:
//    AppOverlay.showLoader(context);
//    AppOverlay.hide();
//
//    AppOverlay.showMessage(
//      context,
//      type: OverlayType.error,
//      title: 'Invalid Email',
//      message: 'Please enter a valid email address.',
//    );
// ─────────────────────────────────────────────────────────────

enum OverlayType { success, error, warning, info }

class AppOverlay {
  static OverlayEntry? _entry;

  static void showLoader(BuildContext context, {String? message}) {
    hide(); 
    _entry = OverlayEntry(
      builder: (_) => _LoaderOverlay(message: message ?? 'Please wait...'),
    );
    Overlay.of(context).insert(_entry!);
  }

  static void showMessage(
    BuildContext context, {
    required OverlayType type,
    required String title,
    required String message,
    VoidCallback? onConfirm,
    String confirmLabel = 'OK',
  }) {
    hide();
    _entry = OverlayEntry(
      builder: (_) => _MessageOverlay(
        type: type,
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        onConfirm: () {
          hide();
          onConfirm?.call();
        },
        onDismiss: hide,
      ),
    );
    Overlay.of(context).insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }
}

// ─────────────────────────────────────────────────────────────
//  LOADER OVERLAY WIDGET
// ─────────────────────────────────────────────────────────────

class _LoaderOverlay extends StatefulWidget {
  final String message;
  const _LoaderOverlay({required this.message});

  @override
  State<_LoaderOverlay> createState() => _LoaderOverlayState();
}

class _LoaderOverlayState extends State<_LoaderOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: Material(
        color: Colors.black.withOpacity(0.45),
        child: Center(
          child: ScaleTransition(
            scale: _scale,
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Custom terracotta circular loader
                  SizedBox(
                    width: 52,
                    height: 52,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.5,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFCD6B5A),
                      ),
                      backgroundColor: const Color(0xFFCD6B5A).withOpacity(0.15),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  MESSAGE OVERLAY WIDGET  (success / error / warning / info)
// ─────────────────────────────────────────────────────────────

class _MessageOverlay extends StatefulWidget {
  final OverlayType type;
  final String title;
  final String message;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final VoidCallback onDismiss;

  const _MessageOverlay({
    required this.type,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.onConfirm,
    required this.onDismiss,
  });

  @override
  State<_MessageOverlay> createState() => _MessageOverlayState();
}

class _MessageOverlayState extends State<_MessageOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final Animation<double> _iconScale;

  // ── Per-type visual config ─────────────────────────────────
  static const _config = {
    OverlayType.success: _OverlayConfig(
      bg: Color(0xFFF0FBF4),
      iconBg: Color(0xFF22C55E),
      icon: Icons.check_rounded,
      accent: Color(0xFF22C55E),
    ),
    OverlayType.error: _OverlayConfig(
      bg: Color(0xFFFFF5F4),
      iconBg: Color(0xFFCD6B5A),
      icon: Icons.close_rounded,
      accent: Color(0xFFCD6B5A),
    ),
    OverlayType.warning: _OverlayConfig(
      bg: Color(0xFFFFFBF0),
      iconBg: Color(0xFFF4C878),
      icon: Icons.warning_amber_rounded,
      accent: Color(0xFFB8860B),
    ),
    OverlayType.info: _OverlayConfig(
      bg: Color(0xFFF0F7FF),
      iconBg: Color(0xFF3B82F6),
      icon: Icons.info_outline_rounded,
      accent: Color(0xFF3B82F6),
    ),
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    )..forward();

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cfg = _config[widget.type]!;

    return FadeTransition(
      opacity: _fade,
      child: Material(
        color: Colors.black.withOpacity(0.45),
        child: GestureDetector(
          onTap: widget.onDismiss, // tap outside to dismiss
          child: Center(
            child: GestureDetector(
              onTap: () {}, // absorb taps inside
              child: SlideTransition(
                position: _slide,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.82,
                  constraints: const BoxConstraints(maxWidth: 340),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.14),
                        blurRadius: 40,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ── Colored header band ──────────────
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 28),
                        decoration: BoxDecoration(
                          color: cfg.bg,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Center(
                          child: ScaleTransition(
                            scale: _iconScale,
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: cfg.iconBg,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: cfg.iconBg.withOpacity(0.35),
                                    blurRadius: 20,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Icon(
                                cfg.icon,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ── Content ──────────────────────────
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                        child: Column(
                          children: [
                            Text(
                              widget.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF1A1A1A),
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF888888),
                                fontSize: 14,
                                height: 1.55,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // ── Confirm button ───────────
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: widget.onConfirm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: cfg.accent,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: const StadiumBorder(),
                                ),
                                child: Text(
                                  widget.confirmLabel,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Internal config model ──────────────────────────────────────
class _OverlayConfig {
  final Color bg;
  final Color iconBg;
  final IconData icon;
  final Color accent;

  const _OverlayConfig({
    required this.bg,
    required this.iconBg,
    required this.icon,
    required this.accent,
  });
}