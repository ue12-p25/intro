// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	integrations: [
		starlight({
			title: 'UE12 - Introduction',
			social: {
				github: 'https://github.com/ue12-p23/intro',
			},
			sidebar: [
				{
					label: 'Introduction',
					items: [
						{ label: 'Présentation', link: '/0-00-presentation-ue12-ue22' },
					],
				},
				{
					label: 'Outils de développement',
					items: [
						{ label: 'Python', link: '/2-03-python' },
					],
				},
			],
		}),
	],
});
