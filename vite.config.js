import { defineConfig } from "vite"
import createReactPlugin from "@vitejs/plugin-react"
import createReScriptPlugin from '@jihchi/vite-plugin-rescript';

export default defineConfig({
  plugins: [createReactPlugin(), createReScriptPlugin()],
})

