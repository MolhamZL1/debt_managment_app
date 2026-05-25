import 'package:flutter/material.dart';

import '../../../../../core/utils/app_images.dart';
import '../../../../../generated/l10n.dart';

class EmptyHomeStateSection extends StatelessWidget {
  const EmptyHomeStateSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset(AppImages.imagesAppIcon, width: 100),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.emptyHomeTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.emptyHomeSubtitle,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
