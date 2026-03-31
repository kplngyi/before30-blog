// @ts-check

import sitemap from '@astrojs/sitemap';
import { defineConfig } from 'astro/config';

export default defineConfig({
	site: 'https://blog.before30.site',
	integrations: [sitemap()],
});
